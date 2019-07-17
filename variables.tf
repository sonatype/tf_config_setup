//Tagging information
variable "team" {
	description = "The team that this account is for."
}

variable "expiration" {
	default = "never"
	description = "The expiration time for the resources created."
}

variable "owner" {
	description = "The email of the owner of the resources."
}

variable "description" {
	description = "The description of the application."
}

variable "use-case" {
	description = "The reason for this configuration (ex. a ticket number)."
}

variable "provisioning" {
	default = "terraform"
	description = "The technology used to provision the resources."
}