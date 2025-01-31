function setAPIbaseurl() as object
  ' API paths 
  this = {}
  if m.global.isProduction
    this.baseURL = "https://gateway.marvel.com/v1/"
  end if
  return this
end function
