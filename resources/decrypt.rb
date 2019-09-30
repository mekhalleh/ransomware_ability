require 'openssl'
require 'digest'

K = "OAdsEsXn9kUmIgG49BEiBqsVzxwKKKbeJkQ0UvKzn9YzVQXIvlJRwu1Fv38jyLSXKPGZxjafQ6C3scUB9sq0JJJ9ywhilfUm8Td9Dvg2rI6D2Hc0YzbImh3WTKCRMwDdNldNQAkzKPkXkZGSGaaQvlvUNJZV5GtfPBDowwTU2J4DHEXl5AUzc5hFtnixqUiXR0YN2a5IgJU2UB0WA5t8YipjpS4Ki7gOZ6NrPzFtdKW7HFXo51GixswdyvHZBSWj"

def do_aes256_decrypt(key, data)
  key        = Digest::SHA256.digest(key) if(key.kind_of?(String) && 32 != key.bytesize)
  cipher     = OpenSSL::Cipher.new('AES-256-CBC').decrypt
  cipher.key = key
  return cipher.update(data) + cipher.final
end

data = ""
File.open('documents.txt.xxxx').each do | line |
  data << line
end

unciphered = do_aes256_decrypt(K, data)

fp = File.open('document.txt', 'wb')
fp.write(unciphered)
fp.close
