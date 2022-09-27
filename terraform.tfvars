fis_role_arn                = "arn:aws:iam::ACCOUNT_ID:role/IAM_ROLE_NAME"
reboot_instances_percentage = 25
reboot_instances_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
stop_instances_percentage = 10
stop_instances_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
start_instances_after_duration = 5
terminate_instances_percentage = 10
terminate_instances_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
send_spot_instance_interruptions_percentage = 50
duration_before_spot_interruption           = 2
send_spot_instance_interruptions_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
reboot_rds_instances_target_arn                             = ["arn:aws:rds:us-west-2:ACCOUNT_ID:db:mysql-instance-1"]
force_failover_db_instance                                  = false
failover_db_cluster_target_arn                              = ["arn:aws:rds:us-west-2:ACCOUNT_ID:cluster:aurora-cluster-1"]
eks_nodegroup_instance_termination_percentage_per_nodegroup = 50
eks_nodegroup_instance_termination_target_tags = {
  key   = "Name"
  value = "fis-eks-nodegroup"
}
ssm_run_memory_stress_experiment_duration     = 5
ssm_run_memory_stress_percent                 = 80
ssm_run_memory_stress_duration_seconds        = 10
ssm_run_memory_stress_install_dependencies    = true
ssm_run_memory_stress_percentage_of_instances = 25
ssm_run_memory_stress_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
ssm_run_cpu_stress_experiment_duration     = 5
ssm_run_cpu_stress_cpu_identifier          = 0
ssm_run_cpu_stress_duration_seconds        = 60
ssm_run_cpu_stress_install_dependencies    = true
ssm_run_cpu_stress_percentage_of_instances = 25
ssm_run_cpu_stress_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
ssm_inject_network_latency_experiment_duration     = 5
ssm_inject_network_latency_interface_id            = "eth0"
ssm_inject_network_latency_delay_milliseconds      = 200
ssm_inject_network_latency_duration_seconds        = 120
ssm_inject_network_latency_install_dependencies    = true
ssm_inject_network_latency_percentage_of_instances = 25
ssm_inject_network_latency_target_tags = {
  key   = "Name"
  value = "fis-ec2-instance"
}
