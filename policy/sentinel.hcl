module "tfplan-functions" {
    source = "./common-functions/tfplan-functions/tfplan-functions.sentinel"
}

module "tfstate-functions" {
    source = "./common-functions/tfstate-functions/tfstate-functions.sentinel"
}

module "tfconfig-functions" {
    source = "./common-functions/tfconfig-functions/tfconfig-functions.sentinel"
}

module "tfrun-functions" {
    source = "./common-functions/tfrun-functions/tfrun-functions.sentinel"
}

policy "restrict-remote-state" {
    source = "./restrict-remote-state.sentinel"
    enforcement_level = "hard-mandatory"
}
