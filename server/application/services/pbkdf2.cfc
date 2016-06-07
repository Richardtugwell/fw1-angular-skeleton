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
