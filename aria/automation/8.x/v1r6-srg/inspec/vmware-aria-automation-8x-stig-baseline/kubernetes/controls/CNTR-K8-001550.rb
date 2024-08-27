control 'CNTR-K8-001550' do
  title 'Kubernetes etcd must have a peer-key-file set for secure communication.'
  desc 'Kubernetes stores configuration and state information in a distributed key-value store called etcd. Anyone who can write to etcd can effectively control a Kubernetes cluster. Even just reading the contents of etcd could easily provide helpful hints to a would-be attacker. Using authenticity protection, the communication can be protected against man-in-the-middle attacks/session hijacking and the insertion of false information into sessions.

The communication session is protected by utilizing transport encryption protocols, such as TLS. TLS provides the Kubernetes API Server and etcd with a means to be able to authenticate sessions and encrypt traffic.

To enable encrypted communication for etcd, the parameter peer-key-file must be set. This parameter gives the location of the SSL certification file used to secure etcd communication.'
  desc 'check', 'Change to the /etc/kubernetes/manifests directory on the Kubernetes Control Plane. Run the command:
grep -i peer-key-file *

If the setting "peer-key-file" is not set in the Kubernetes etcd manifest file, this is a finding.'
  desc 'fix', 'Edit the Kubernetes etcd manifest file in the /etc/kubernetes/manifests directory on the Kubernetes Control Plane.

Set the value of "--peer-key-file" to the certificate to be used for communication with etcd.'
  impact 0.5
  ref 'DPMS Target Kubernetes'
  tag check_id: 'C-45708r863887_chk'
  tag severity: 'medium'
  tag gid: 'V-242433'
  tag rid: 'SV-242433r879636_rule'
  tag stig_id: 'CNTR-K8-001550'
  tag gtitle: 'SRG-APP-000219-CTR-000550'
  tag fix_id: 'F-45666r863888_fix'
  tag 'documentable'
  tag cci: ['CCI-001184']
  tag nist: ['SC-23']

  if etcd.exist?
    describe.one do
      describe etcd do
        its('peer-key-file') { should_not be_nil }
      end
      # Environment variables: every flag has a corresponding environment variable that has the same name but is prefixed with ETCD_ and formatted in all caps and snake case. For example, --some-flag would be ETCD_SOME_FLAG.
      describe process_env_var('etcd') do
        its(:ETCD_PEER_KEY_FILE) { should_not be_nil }
      end
    end
  else
    impact 0.0
    describe 'The Kubernetes etcd process is not running on the target so this control is not applicable.' do
      skip 'The Kubernetes etcd process is not running on the target so this control is not applicable.'
    end
  end
end
