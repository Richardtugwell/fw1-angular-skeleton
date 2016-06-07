/*
The MIT License (MIT)

Copyright (c) 2016 Ryan Guill

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

component accessors = true	{

    public struct function hashPasswordPBKDF2 (required string password, numeric iterations = 100000, numeric saltByteLength = 8) {
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
    public string function hashPassword (required string password, numeric iterations = 100000, numeric saltByteLength = 8) {
        var out = hashPasswordPBKDF2(argumentCollection=arguments);
        return out.iterations & ":" & out.salt & ":" & out.hash;
    }
    public boolean function checkPassword (required string attemptedPassword, required string storedPassword) {
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

}
