### Changes for /usr/share/perl5/PVE/API2/Qemu.pm

# POST/PUT {vmid}/config implementation
#
# The original API used PUT (idempotent) an we assumed that all operations
# are fast. But it turned out that almost any configuration change can
# involve hot-plug actions, or disk alloc/free. Such actions can take long
# time to complete and have side effects (not idempotent).
#
# The new implementation uses POST and forks a worker process. We added
# a new option 'background_delay'. If specified we wait up to
# 'background_delay' second for the worker task to complete. It returns null
# if the task is finished within that time, else we return the UPID.

my $update_vm_api  = sub {
    my ($param, $sync) = @_;

    my $rpcenv = PVE::RPCEnvironment::get();

    my $authuser = $rpcenv->get_user();

    my $node = extract_param($param, 'node');

    my $vmid = extract_param($param, 'vmid');

    my $digest = extract_param($param, 'digest');

    my $background_delay = extract_param($param, 'background_delay');

+    my $conf = PVE::QemuConfig->load_config($vmid);
+    my $ostype = $conf->{ostype};
    if (defined(my $cipassword = $param->{cipassword})) {
        # Same logic as in cloud-init (but with the regex fixed...)
+        if (!(PVE::QemuServer::windows_version($ostype))) {
            $param->{cipassword} = PVE::Tools::encrypt_pw($cipassword)
                if $cipassword !~ /^\$(?:[156]|2[ay])(\$.+){2}/;
+        }
    }
