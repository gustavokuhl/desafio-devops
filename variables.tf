variable "aws" {

  type = map(string)

  default = (
    {
      region  = "us-east-1"
      access_key = ""
      secret_key = ""
      key_pair_name = ""
    }
  )

}