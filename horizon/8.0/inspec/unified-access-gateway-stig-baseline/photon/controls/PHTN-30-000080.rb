# -*- encoding : utf-8 -*-
control "PHTN-30-000080" do
  title "The Photon operating system must configure sshd to disable X11 forwarding."
  desc  "X11 is an older, insecure graphics forwarding protocol. It is not used by Photon and should be disabled as a general best practice to limit attack surface area and communication channels."
  desc  "rationale", ""
  desc  "check", "
    At the command line, execute the following command:
    
    # sshd -T|&grep -i X11Forwarding
    
    Expected result:
    
    X11Forwarding no
    
    If the output does not match the expected result, this is a finding.
  "
  desc  "fix", "
    Navigate to and open:
    
    /etc/ssh/sshd_config
    
    Ensure that the \"X11Forwarding\" line is uncommented and set to the following:
    
    X11Forwarding no
    
    At the command line, execute the following command:
    
    # systemctl restart sshd.service
  "
  impact 0.5
  tag severity: "medium"
  tag gtitle: "SRG-OS-000480-GPOS-00227"
  tag gid: nil
  tag rid: nil
  tag stig_id: "PHTN-30-000080"
  tag cci: ["CCI-000366"]
  tag nist: ["CM-6 b"]
  
  sshdcommand = input('sshdcommand')
  describe command("#{sshdcommand}|&grep -i X11Forwarding") do
    its('stdout.strip') { should cmp 'X11Forwarding no' }
  end
end