#default["cloud-benchmarking-server"]["SOME-ATTRIBUTE"] = "my cloud benchmarking specific attribute"

default["rackbox"]["ruby"]["versions"] = 	   [ "2.1.1" ]
default["rackbox"]["ruby"]["global_version"] =   "2.1.1"

# Vagrant configuration
default["vagrant"]["url"] = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.3_x86_64.deb"
default["vagrant"]["checksum"] = "430c5553aeb3f2f5ff30c8c32a565db16669eaf76a553e3e1ceff27cbe6cb2b2"
default["vagrant"]["plugins"] = [
    { "name" => "vagrant-aws", 	   "version" =>  "0.4.1" },
    { "name" => "vagrant-omnibus", "version" =>  "1.3.1" },
	{ "name" => "chef", 		   "version" => "11.6.2" }
  ]
default["vagrant"]["plugins_user"] = "apps"
default["vagrant"]["plugins_group"] = "apps"