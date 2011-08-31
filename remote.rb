#!/usr/bin/ruby


authorized_keys_file = File.expand_path("~/.ssh/authorized_keys")

#check to see if there is an authorized_keys
unless File.exists?(authorized_keys_file)
  #create the authorized_keys file
  unless File.exists?(File.expand_path("~/.ssh/"))
    #create the .ssh directory
    system "mkdir .ssh"
  end
  system "touch .ssh/authorized_keys"
end

#cat the id_rsa.pub to the end of the authorized keys
system "cat id_rsa.pub >> .ssh/authorized_keys"

system "chmod 700 .ssh"
system "chmod 600 .ssh/authorized_keys"

