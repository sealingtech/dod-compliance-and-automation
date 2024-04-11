control 'VRPS-8X-000141' do
  title 'The VMware Aria Operations Casa service example applications must be removed.'
  desc  'Tomcat provides example applications, documentation, and other directories in the default installation that do not serve a production use. These files must be deleted.'
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # ls -l /usr/lib/vmware-casa/casa-webapp/webapps/examples

    If the examples folder exists or contains any content, this is a finding.
  "
  desc 'fix', "
    At the command prompt, run the following command:

    # rm -rf /usr/lib/vmware-casa/casa-webapp/webapps/examples
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000141-AS-000095'
  tag gid: 'V-VRPS-8X-000141'
  tag rid: 'SV-VRPS-8X-000141'
  tag stig_id: 'VRPS-8X-000141'
  tag cci: ['CCI-000381']
  tag nist: ['CM-7 a']

  # Make sure the examples directory does not exist
  describe directory("#{input('casa-tcInstance')}/webapps/examples").exist? do
    it { should cmp 'false' }
  end
end
