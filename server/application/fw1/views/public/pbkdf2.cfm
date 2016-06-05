<cfscript>
    struct function hashPasswordPBKDF2 (required string password, numeric iterations = 10000, numeric saltByteLength = 8) {
        if (iterations < 100000) {
            throw(message="Iterations must be greater than or equal to 100000");
        }
        if (saltbytelength < 8) {
            throw(message="SaltByteLength must be greater than or equal to 8");
        }
        if (len(trim(password)) == 0) {
            throw(message="Password cannot be an empty string.");
        }
        var random = createObject("java", "java.security.SecureRandom").getInstance("SHA1PRNG");
        var salt = createObject("java", "java.nio.ByteBuffer").allocate(saltByteLength).array();
        random.nextBytes(salt);
        var derivedKeyLength = 160; /*this is the length of the sha1 hash */
        var spec = createObject("java", "javax.crypto.spec.PBEKeySpec").init(password.toCharArray(), salt, iterations, derivedKeyLength);
        var keyFactory = createObject("java", "javax.crypto.SecretKeyFactory").getInstance("PBKDF2WithHmacSHA1");
        return {
            iterations = iterations,
            salt = binaryEncode(salt, "HEX"),
            hash = binaryEncode(keyFactory.generateSecret(spec).getEncoded(), "HEX")
        };
    }
    string function hashPassword (required string password, numeric iterations = 100000, numeric saltByteLength = 8) {
        var out = hashPasswordPBKDF2(argumentCollection=arguments);
        return out.iterations & ":" & out.salt & ":" & out.hash;
    }
    boolean function checkPassword (required string attemptedPassword, required string storedPassword) {
        var parts = listToArray(storedPassword, ":");
        if (arrayLen(parts) != 3) {
            throw(message="Invalid Stored Password, expected 3 parts separated by colon");
        }
        var iterations = parts[1];
        var salt = binaryDecode(parts[2], "HEX");
        var hash = binaryDecode(parts[3], "HEX");
        var spec = createObject("java","javax.crypto.spec.PBEKeySpec").init(attemptedPassword.toCharArray(), salt, iterations, arrayLen(hash) * 8);
        var keyFactory = createObject("java","javax.crypto.SecretKeyFactory").getInstance("PBKDF2WithHmacSHA1");
        return compare(binaryEncode(keyFactory.generateSecret(spec).getEncoded(), "HEX"), parts[3]) == 0;
    }
</cfscript>
<!--- ==================================================== --->
<cfparam name="url.input" default="your-password-here" />
<cfparam name="url.hashIterations" default="100000" />
<cfparam name="url.saltByteLength" default="8" />
<cfparam name="url.count" default="15" />
<cfif NOT isNumeric(url.hashIterations) OR url.hashIterations LT 100000>
    <cfset url.hashIterations = 100000 />
</cfif>
<cfif NOT isNumeric(url.count)>
    <cfset url.hashIterations = 15 />
</cfif>
<cfif NOT isNumeric(url.saltByteLength) OR url.saltByteLength LT 8>
    <cfset url.saltByteLength = 8 />
</cfif>
<cfset hashedPasswords = [] />
<cfset totalEncryptionTime = totalCheckTime = 0 />
<cfloop from="1" to="#url.count#" index="i">
    <cfset startTC = getTickCount() />
    <cfset data = {
            password:url.input,encryptedPassword:hashPassword(url.input, url.hashIterations, url.saltByteLength)
        } />
    <cfset data.time = getTickCount() - startTC />
    <cfset totalEncryptionTime += data.time />
    <cfset arrayAppend(hashedPasswords,data) />
</cfloop>
<!--- ==================================================== --->
<html>
<head>
    <title>PBKDF2 CF Example</title>
    <style>
        table {
            font-family: Courier, monospace;
            font-size: 10pt;
        }
        th, td  {
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <cfoutput>
        <h3>PBKDF2 in CF</h3>
        <a href="https://gist.github.com/ryanguill/11405725">https://gist.github.com/ryanguill/11405725</a><br />
    References: <br />
    <ol>
        <li><a href="http://howtodoinjava.com/2013/07/22/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/">http://howtodoinjava.com/2013/07/22/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/</a></li>
        <li><a href="http://www.javacodegeeks.com/2012/05/secure-password-storage-donts-dos-and.html">http://www.javacodegeeks.com/2012/05/secure-password-storage-donts-dos-and.html</a></li>
        <li><a href="https://en.wikipedia.org/wiki/PBKDF2">https://en.wikipedia.org/wiki/PBKDF2</a></li>
        <li><a href="http://blog.codinghorror.com/speed-hashing/">http://blog.codinghorror.com/speed-hashing/</a></li>
        <li><a href="http://security.stackexchange.com/questions/3959/recommended-of-iterations-when-using-pkbdf2-sha256">http://security.stackexchange.com/questions/3959/recommended-of-iterations-when-using-pkbdf2-sha256</a></li>
        <li><a href="https://news.ycombinator.com/item?id=3724560">https://news.ycombinator.com/item?id=3724560</a></li>
    </ol>
    <div style="width: 1000px;">
    <p>This is an example and test of hashing passwords in CFML using PBKDF2.  I believe this requires JRE 6+; I have only tested on 7 and 8. I have tested this on CF10+ and Lucee 4.5+.  I developed this as an alternative to brcypt - which some say is better (slower) than PBKDF2, but requires the use of a class such as jBcrypt.  This solution was written intentionally to be able to use Java standard libraries and make it easier to use. <a href="https://news.ycombinator.com/item?id=3724560">[6]</a>. From what I can tell, the consensus is you should use one of these PBKDF2, bcrypt or <a href="http://www.tarsnap.com/scrypt.html">scrypt</a>.</p>
    <p>The two functions are:<br />
        <ul>
            <li>String hashPassword(String required password, Numeric iterations = 100000, Numeric saltByteLength = 8)</li>
            <li>String checkPassword(String required attemptedPassword, String required storedPassword)</li>
        </ul></p>
    <p>The hashPassword() function will take the password you want to hash (and optionally the number of iterations) and return to you a string that contains the number of iterations, the salt and the password.  You can (and should) store all of these in one field in the database.</p>
    <p>To validate a password, look the user up by their username or some other unique identifier, retrieve the hashed password with the iterations and salt, and then call checkPassword with the cleartext attempted password and the 3 part hashed password.  It will return true if the attempted password is valid.</p>
    <p>The salt is not secret, it is ok to store with the encrypted password.  It is suggested that you set the iterations as high as you can stand - the more iterations the longer it takes to encrypt and check the password, but the longer it will take an attacker to do the same. See: <a href="http://security.stackexchange.com/questions/3959/recommended-of-iterations-when-using-pkbdf2-sha256">[5]</a>.  You can use this form to test the times to see how many iterations you can stand to use. But keep in mind the number of iterations matter as much as the salt or the encrypted password - when checking the password you have to know the exact number of iterations used to encrypt the password initially.</p>
    <p>The other thing that iterations does for you is allow you to ramp up the number of iterations to scale with CPU capabilities.  As long as you are storing the number of iterations you are using (as this does), you and and should slowly expand the number of iterations used in new hashed passwords as time goes on and clock speeds advance.</p>
    <p>Of course I suggest that you put these two functions in whatever service you are using for authentication, but I have tried to make it easy enough to just copy and paste them both.</p>
    <p>If you see anything to improve or fix with this script, or this accompanying information, please contact me or send a pull request. If you are going to tweak the two functions, remember that the goal is to keep the keyFactory.generateSecret() call slow, but everything else fast.  If someone is going to attempt to crack the passwords, thats the part they will be implementing, not the rest of the code.  We want that call to be as slow as tollerable, but everything else to be as fast as possible.</p>
    </div>
    <hr />
    <form action="pbkdf2.cfm##form" method="get">
        <a name="form">PBKDF2 Password:</a> <input type="text" name="input" value="#url.input#" />
        Hash Iterations: <input type="text" name="hashIterations" value="#url.hashIterations#" size="4" />
        Salt Byte Length: <input type="text" name="saltByteLength" value="#url.saltByteLength#" size="4" />
        Count: <input type="text" name="count" value="#url.count#" size="4" />
        <input type="submit" />
    </form>
    <hr />

    <table >
        <tr>
            <th>Password</th>
            <th>Encrypted Password (store this in the db and provide to checkPassword())</th>
            <th>Length</th>
            <th>CheckPassword</th>
            <th style="text-align: right;">encryption time</th>
            <th style="text-align: right;">checkPassword time</th>
        </tr>
        <cfloop array="#hashedPasswords#" index="data">
            <tr>
                <td>#data.password#</td>
                <td>#data.encryptedPassword#</td>
                <td>#len(data.encryptedPassword)#</td>

                <cfset startTC = getTickCount() />
                    <td>#checkPassword(data.password, data.encryptedPassword)#</td>
                <cfset checkPasswordTime = getTickCount() - startTC />
                <cfset totalCheckTime += checkPasswordTime />
                <td style="text-align: right;">#data.time# ms.</td>
                <td style="text-align: right;">#checkPasswordTime# ms.</td>
            </tr>
        </cfloop>
        <tr>
            <td colspan="4" style="text-align: right;">Totals:</td>
            <td style="text-align: right;">#totalEncryptionTime# ms.</td>
            <td style="text-align: right;">#totalCheckTime# ms.</td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: right;">Avg:</td>
            <td style="text-align: right;">#numberFormat(totalEncryptionTime / arrayLen(hashedPasswords),"9.99")# ms.</td>
            <td style="text-align: right;">#numberFormat(totalCheckTime / arrayLen(hashedPasswords),"9.99")# ms.</td>
        </tr>
    </table>

    </cfoutput>
</body>
</html>
