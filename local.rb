#!/usr/bin/ruby 
username = ARGV[0]
server = ARGV[1]
ssh_key = File.expand_path("~/.ssh/id_rsa.pub")
ssh_key_file_name = "id_rsa.pub"
remote_file_name = "remote.rb"
#check for local ssh key and setup if necessary
unless File.exist?(ssh_key)
  #need to prompt the user to create the key
  puts "You have not setup your public and private keys.  You will now do that.  After you have done that we will complete the process"
  `ssh-keygen -t rsa`
end
#upload the ssh key
puts "Uploading the ssh key to remote server"

system "scp #{ssh_key} #{username}@#{server}:#{ssh_key_file_name}"

#upload the remote file to the server
puts "Uploading the ruby script to the remote server"
system "scp remote.rb #{username}@#{server}:#{remote_file_name}"

#execute the script on the remote server
puts "Executing the script on the server"
system "ssh #{username}@#{server} 'ruby remote.rb'"

#clean up the script
puts "Cleaning up the files on the server"
system "ssh #{username}@#{server} 'rm -rf id_rsa.pub; rm -rf remote.rb'"