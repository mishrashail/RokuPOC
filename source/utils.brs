function setAPIbaseurl() as object
  ' API paths 
  this = {}
  if m.global.isProduction
    this.baseURL = "https://gateway.marvel.com/v1/"
  end if
  return this
end function

sub loadConfigJson()
  ' Get the path to the config file
	configFilePath = "pkg:/components/config.json"

	' Read the content of the config file
	configFile = ReadAsciiFile(configFilePath)
  
	' Parse the JSON content
	configData = ParseJson(configFile)
  
	' Access the values
	m.publicKey = configData.public_key
	m.hash = configData.hash
	m.ts = configData.ts
  
	? "Public Key: " + m.publicKey
	? "Hash: " + m.hash
	? "Timestamp: " + m.ts

end sub
