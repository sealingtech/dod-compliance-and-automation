control 'PHTN-30-000240' do
  title 'The Photon operating system must implement NIST FIPS-validated cryptography for the following: to provision digital signatures, generate cryptographic hashes, and protect unclassified information requiring confidentiality and cryptographic protection in accordance with applicable federal laws, Executive Orders, directives, policies, regulations, and standards.'
  desc  'Use of weak or untested encryption algorithms undermines the purposes of using encryption to protect data. The operating system must implement cryptographic modules adhering to the higher standards approved by the federal government because this provides assurance they have been tested and validated.'
  desc  'rationale', ''
  desc  'check', "
    At the command line, run the following command:

    # cat /proc/sys/crypto/fips_enabled

    If a value of \"1\" is not returned, this is a finding.
  "
  desc 'fix', "
    Navigate to and open:

    /boot/grub2/grub.cfg

    Locate the kernel command line, which will start with \"linux\", and add \"fips=1\" to the end. For example:

    linux /$photon_linux audit=1 root=$rootpartition $photon_cmdline coredump_filter=0x37 consoleblank=0 $systemd_cmdline fips=1

    Reboot the system for the change to take effect.

    Note: The \"fipsify\" package must be installed for FIPS mode to work properly.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-OS-000478-GPOS-00223'
  tag gid: 'V-256589'
  tag rid: 'SV-256589r887441_rule'
  tag stig_id: 'PHTN-30-000240'
  tag cci: ['CCI-002450']
  tag nist: ['SC-13']

  describe file('/proc/sys/crypto/fips_enabled') do
    its('content') { should cmp 1 }
  end
end
