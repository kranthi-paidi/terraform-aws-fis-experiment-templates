
variable "fis_role_arn" {
  description = "The ARN of the IAM role that AWS FIS uses to perform experiments on your behalf."
  type        = string
}

# Variables for reboot instances experiment template
variable "reboot_instances_percentage" {
  description = "The percentage of EC2 instances to reboot."
  type        = number
}
variable "reboot_instances_target_tags" {
  description = "The tags to use to identify the EC2 instances to reboot."
  type = object({
    key   = string
    value = string
  })
}


# Variables for stop instances experiment template
variable "stop_instances_percentage" {
  description = "The percentage of EC2 instances to stop."
  type        = number
}
variable "stop_instances_target_tags" {
  description = "The tags to use to identify the EC2 instances to stop."
  type = object({
    key   = string
    value = string
  })
}
variable "start_instances_after_duration" {
  description = "The duration to wait before starting the EC2 instances."
  type        = number
}


# Variables for terminate instances experiment template
variable "terminate_instances_percentage" {
  description = "The percentage of EC2 instances to terminate."
  type        = number
}
variable "terminate_instances_target_tags" {
  description = "The tags to use to identify the EC2 instances to terminate."
  type = object({
    key   = string
    value = string
  })
}


# Variables for send spot instance interruptions experiment template
variable "send_spot_instance_interruptions_percentage" {
  description = "The percentage of Spot Instances to send interruptions to."
  type        = number
}
variable "duration_before_spot_interruption" {
  description = "The duration to wait before sending the Spot Instance interruption."
  type        = number
}
variable "send_spot_instance_interruptions_target_tags" {
  description = "The tags to use to identify the Spot Instances to send interruptions to."
  type = object({
    key   = string
    value = string
  })
}


# Variables for reboot rds instances experiment template
variable "force_failover_db_instance" {
  description = "A Boolean value that indicates whether the reboot is conducted through a Multi-AZ failover."
  type        = bool
}
variable "reboot_rds_instances_target_arn" {
  description = "The ARNs of the RDS instances to reboot."
  type        = list(string)
}


# Variables for failover db cluster experiment template
variable "failover_db_cluster_target_arn" {
  description = "The ARNs of the RDS clusters to failover."
  type        = list(string)
}


# Variables for EKS Terminate Node Groups experiment template
variable "eks_nodegroup_instance_termination_percentage_per_nodegroup" {
  description = "The percentage of EKS node groups to terminate."
  type        = number
}
variable "eks_nodegroup_instance_termination_target_tags" {
  description = "The tags to use to identify the EKS node groups to terminate."
  type = object({
    key   = string
    value = string
  })
}


# Variables for running Memory Stress experiment template
variable "ssm_run_memory_stress_experiment_duration" {
  # This is different from ssm_run_memory_stress_duration_seconds
  # This variable controls the duration of the experiment while the other controls the duration of the stress
  # Typically, the experiment duration is longer than the stress duration to observe the effects of the stress
  description = "The duration to run the memory stress experiment."
  type        = number
}
variable "ssm_run_memory_stress_percent" {
  description = "The percentage of memory to stress."
  type        = number
}
variable "ssm_run_memory_stress_duration_seconds" {
  description = "The duration to run the memory stress."
  type        = number
}
variable "ssm_run_memory_stress_install_dependencies" {
  description = "A Boolean value that indicates whether to install dependencies."
  type        = bool
}
variable "ssm_run_memory_stress_percentage_of_instances" {
  description = "The percentage of instances to run the memory stress on."
  type        = number
}
variable "ssm_run_memory_stress_target_tags" {
  description = "The tags to use to identify the instances to run the memory stress on."
  type = object({
    key   = string
    value = string
  })
}


# Variables for running CPU Stress experiment template
variable "ssm_run_cpu_stress_experiment_duration" {
  # This is different from ssm_run_cpu_stress_duration_seconds
  # This variable controls the duration of the experiment while the other controls the duration of the stress
  # Typically, the experiment duration is longer than the stress duration to observe the effects of the stress
  description = "The duration in minutes to run the CPU stress experiment."
  type        = number
}
variable "ssm_run_cpu_stress_cpu_identifier" {
  # Optional. The number of CPU stressors to use. The default is 0, which uses all CPU stressors
  description = "The CPU identifier to stress."
  type        = number
  default     = 0
}
variable "ssm_run_cpu_stress_duration_seconds" {
  description = "The duration in seconds to run the CPU stress."
  type        = number
}
variable "ssm_run_cpu_stress_install_dependencies" {
  description = "A Boolean value that indicates whether to install dependencies."
  type        = bool
}
variable "ssm_run_cpu_stress_percentage_of_instances" {
  description = "The percentage of instances to run the CPU stress on."
  type        = number
}
variable "ssm_run_cpu_stress_target_tags" {
  description = "The tags to use to identify the instances to run the CPU stress on."
  type = object({
    key   = string
    value = string
  })
}


# variables for running EC2 Network Latency experiment template
variable "ssm_inject_network_latency_experiment_duration" {
  # This is different from ssm_inject_network_latency_duration_seconds
  # This variable controls the duration of the experiment while the other controls the duration of the stress
  # Typically, the experiment duration is longer than the stress duration to observe the effects of the stress
  description = "The duration in minutes to run the network latency experiment."
  type        = number
}
variable "ssm_inject_network_latency_interface_id" {
  description = "The ID of the network interface to inject latency on."
  type        = string
}
variable "ssm_inject_network_latency_delay_milliseconds" {
  description = "The delay in milliseconds to inject."
  type        = number
}
variable "ssm_inject_network_latency_duration_seconds" {
  description = "The duration in seconds to inject the network latency."
  type        = number
}
variable "ssm_inject_network_latency_install_dependencies" {
  description = "A Boolean value that indicates whether to install dependencies."
  type        = bool
}
variable "ssm_inject_network_latency_percentage_of_instances" {
  description = "The percentage of instances to inject the network latency on."
  type        = number
}
variable "ssm_inject_network_latency_target_tags" {
  description = "The tags to use to identify the instances to inject the network latency on."
  type = object({
    key   = string
    value = string
  })
}

