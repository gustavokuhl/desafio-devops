variable "aws" {

  type = object({
    profile = string
    region  = string
  })

  default = (
    {
      profile = "dev"
      region  = "us-east-1"
    }
  )

}