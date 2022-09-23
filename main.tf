terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = ">= 2.0.0"
  }
}

provider "aws" {
  region = "us-west-2"
}

###############################################################################
# AWS EC2 FIS Experiment Templates
###############################################################################

# AWS EC2 FIS Experiment - Reboot EC2 Instances

resource "aws_fis_experiment_template" "ec2-reboot-instance" {
  description = "Reboot EC2 Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:ec2:reboot-instances"
    name        = "Reboot-EC2-Instances"
    description = "Reboot EC2 Instances"

    target {
      key   = "Instances"
      value = "reboot-instances-target"
    }
  }

  target {
    name           = "reboot-instances-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "PERCENT(${var.reboot_instances_percentage})"

    resource_tag {
      key   = var.reboot_instances_target_tags.key
      value = var.reboot_instances_target_tags.value
    }
  }

}

# AWS EC2 FIS Experiment - Stop EC2 Instances

resource "aws_fis_experiment_template" "ec2-stop-instance" {
  description = "Stop EC2 Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:ec2:stop-instances"
    name        = "Stop-EC2-Instances"
    description = "Stop EC2 Instances"

    target {
      key   = "Instances"
      value = "stop-instances-target"
    }

    parameter {
      key   = "startInstancesAfterDuration"
      value = "PT${var.start_instances_after_duration}M"
    }
  }

  target {
    name           = "stop-instances-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "PERCENT(${var.stop_instances_percentage})"

    resource_tag {
      key   = var.stop_instances_target_tags.key
      value = var.stop_instances_target_tags.value
    }
  }

}

# AWS EC2 FIS Experiment - Terminate EC2 Instances
resource "aws_fis_experiment_template" "ec2-terminate-instances" {
  description = "Terminate EC2 Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:ec2:terminate-instances"
    name        = "Terminate-EC2-Instances"
    description = "Terminate EC2 Instances"

    target {
      key   = "Instances"
      value = "terminate-instances-target"
    }
  }

  target {
    name           = "terminate-instances-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "PERCENT(${var.terminate_instances_percentage})"

    resource_tag {
      key   = var.terminate_instances_target_tags.key
      value = var.terminate_instances_target_tags.value
    }
  }
}

# AWS EC2 FIS Experiment - Send Spot Instance Interruptions
# BUG : https://github.com/hashicorp/terraform-provider-aws/issues/26950
# Sep 22, 2022: Currently, there seems to be a bug that is preventing the creation of this experiment template.
# The bug is related to the fact that the "aws:ec2:send-spot-instance-interruptions" does not accept Instances as a target

# resource "aws_fis_experiment_template" "ec2_send_spot_instance_interruptions" {
#   description = "Send Spot Instance Interruptions"
#   role_arn    = var.fis_role_arn
#   stop_condition {
#     source = "none"
#   }

#   action {
#     action_id   = "aws:ec2:send-spot-instance-interruptions"
#     name        = "Send-Spot-Instance-Interruptions"
#     description = "Send Spot Instance Interruptions"

#     target {
#       key   = "Instances"
#       value = "send-spot-instance-interruptions-target"
#     }

#     parameter {
#       key   = "durationBeforeInterruption"
#       value = "PT${var.duration_before_spot_interruption}M"
#     }
#   }

#   target {
#     name           = "send-spot-instance-interruptions-target"
#     resource_type  = "aws:ec2:spot-instance"
#     selection_mode = "PERCENT(${var.send_spot_instance_interruptions_percentage})"

#     resource_tag {
#       key   = var.send_spot_instance_interruptions_target_tags.key
#       value = var.send_spot_instance_interruptions_target_tags.value
#     }
#   }
# }

###############################################################################
# AWS RDS FIS Experiment Templates
###############################################################################

# AWS RDS FIS Experiment - Reboot RDS Instances
resource "aws_fis_experiment_template" "rds-reboot-instance" {
  description = "Reboot RDS Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:rds:reboot-db-instances"
    name        = "Reboot-RDS-Instances"
    description = "Reboot RDS Instances"

    target {
      key   = "DBInstances"
      value = "reboot-db-instance-target"
    }

    parameter {
      key   = "forceFailover"
      value = var.force_failover_db_instance
    }
  }

  target {
    name           = "reboot-db-instance-target"
    resource_type  = "aws:rds:db"
    selection_mode = "ALL"

    resource_arns = var.reboot_rds_instances_target_arn
  }
}

# AWS RDS FIS Experiment - Failover DB Cluster

resource "aws_fis_experiment_template" "rds-failover-db-cluster" {
  description = "Failover DB Cluster"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:rds:failover-db-cluster"
    name        = "Failover-DB-Cluster"
    description = "Failover DB Cluster"

    target {
      key   = "Clusters"
      value = "failover-db-cluster-target"
    }
  }

  target {
    name           = "failover-db-cluster-target"
    resource_type  = "aws:rds:cluster"
    selection_mode = "ALL"

    resource_arns = var.failover_db_cluster_target_arn
  }

}

###############################################################################
# AWS EKS FIS Experiment Templates
###############################################################################

# AWS EKS FIS Experiment - Terminate nodegroup Instances
resource "aws_fis_experiment_template" "eks-terminate-nodegroup-instances" {
  description = "Terminate nodegroup Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:eks:terminate-nodegroup-instances"
    name        = "Terminate-nodegroup-Instances"
    description = "Terminate nodegroup Instances"

    target {
      key   = "Nodegroups"
      value = "terminate-nodegroup-instances-target"
    }

    parameter {
      # The percentage of instances that will be terminated per nodegroup.
      key   = "instanceTerminationPercentage"
      value = var.eks_nodegroup_instance_termination_percentage_per_nodegroup
    }
  }

  target {
    name           = "terminate-nodegroup-instances-target"
    resource_type  = "aws:eks:nodegroup"
    selection_mode = "ALL"
    resource_tag {
      key   = var.eks_nodegroup_instance_termination_target_tags.key
      value = var.eks_nodegroup_instance_termination_target_tags.value
    }
  }
}

###############################################################################
# AWS Systems Manager FIS Experiment Templates
###############################################################################
###############################################################################
# NOTE: For actions that require SSM Agent to run the action on the target, you must ensure the following:
# 1. The agent is installed on the target. SSM Agent is installed by default on some Amazon Machine Images (AMIs). 
# Otherwise, you can install the SSM Agent on your instances. 
# For more information, see https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-manual-agent-install.html
#
# 2. Systems Manager has permission to perform actions on your instances. 
# You grant access using an IAM instance profile. 
# For more information, see https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-instance-profile.html
# and see https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-launch-managed-instance.html
# AWS Systems Manager FIS Experiment - Run Memory Stress

resource "aws_fis_experiment_template" "ssm-run-memory-stress" {
  # Runs memory stress on an instance using the stress-ng tool
  # Requires stress-ng to be installed on the instance. Set InstallDependencies in parameters to True to install stress-ng.
  description = "Run Memory Stress on EC2 Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:ssm:send-command"
    name        = "Run-Memory-Stress"
    description = "Run Memory Stress"

    target {
      key   = "Instances"
      value = "run-memory-stress-target"
    }

    parameter {
      key   = "documentArn"
      value = "arn:aws:ssm:us-west-2::document/AWSFIS-Run-Memory-Stress"
    }

    parameter {
      key   = "documentVersion"
      value = "$LATEST"
    }

    parameter {
      key   = "duration"
      value = "PT${var.ssm_run_memory_stress_experiment_duration}M"
    }

    parameter {
      key = "documentParameters"
      value = jsonencode({
        "Percent"             = var.ssm_run_memory_stress_percent
        "DurationSeconds"     = var.ssm_run_memory_stress_duration_seconds
        "InstallDependencies" = var.ssm_run_memory_stress_install_dependencies
      })
    }
  }

  target {
    name           = "run-memory-stress-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "PERCENT(${var.ssm_run_memory_stress_percentage_of_instances})"
    resource_tag {
      key   = var.ssm_run_memory_stress_target_tags.key
      value = var.ssm_run_memory_stress_target_tags.value
    }
  }

}

# AWS Systems Manager FIS Experiment - Run CPU Stress
resource "aws_fis_experiment_template" "sss-run-cpu-stress" {
  # Runs CPU stress on an instance using the stress-ng tool
  # Requires stress-ng to be installed on the instance. Set InstallDependencies in parameters to True to install stress-ng.
  description = "Run CPU Stress on EC2 Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:ssm:send-command"
    name        = "Run-CPU-Stress"
    description = "Run CPU Stress"

    target {
      key   = "Instances"
      value = "run-cpu-stress-target"
    }

    parameter {
      key   = "documentArn"
      value = "arn:aws:ssm:us-west-2::document/AWSFIS-Run-CPU-Stress"
    }

    parameter {
      key   = "documentVersion"
      value = "$LATEST"
    }

    parameter {
      key   = "duration"
      value = "PT${var.ssm_run_cpu_stress_experiment_duration}M"
    }

    parameter {
      key = "documentParameters"
      value = jsonencode({
        "CPU"                 = var.ssm_run_cpu_stress_cpu_identifier
        "DurationSeconds"     = var.ssm_run_cpu_stress_duration_seconds
        "InstallDependencies" = var.ssm_run_cpu_stress_install_dependencies
      })
    }
  }

  target {
    name           = "run-cpu-stress-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "PERCENT(${var.ssm_run_cpu_stress_percentage_of_instances})"
    resource_tag {
      key   = var.ssm_run_cpu_stress_target_tags.key
      value = var.ssm_run_cpu_stress_target_tags.value
    }
  }
}

# AWS Systems Manager FIS Experiment - Inject Network Latency on an EC2 instance

resource "aws_fis_experiment_template" "ssm-inject-network-latency-on-ec2-instance" {
  # Injects network latency on an instance using the tc tool
  # Requires tc to be installed on the instance. Set InstallDependencies in parameters to True to install tc.
  description = "Inject Network Latency on EC2 Instances"
  role_arn    = var.fis_role_arn
  stop_condition {
    source = "none"
  }

  action {
    action_id   = "aws:ssm:send-command"
    name        = "Inject-Network-Latency"
    description = "Inject Network Latency"

    target {
      key   = "Instances"
      value = "inject-network-latency-target"
    }

    parameter {
      key   = "documentArn"
      value = "arn:aws:ssm:us-west-2::document/AWSFIS-Run-Network-Latency"
    }

    parameter {
      key   = "documentVersion"
      value = "$LATEST"
    }

    parameter {
      key   = "duration"
      value = "PT${var.ssm_inject_network_latency_experiment_duration}M"
    }

    parameter {
      key = "documentParameters"
      value = jsonencode({
        "Interface"           = var.ssm_inject_network_latency_interface_id
        "DelayMilliseconds"   = var.ssm_inject_network_latency_delay_milliseconds
        "DurationSeconds"     = var.ssm_inject_network_latency_duration_seconds
        "InstallDependencies" = var.ssm_inject_network_latency_install_dependencies
      })
    }
  }

  target {
    name           = "inject-network-latency-target"
    resource_type  = "aws:ec2:instance"
    selection_mode = "PERCENT(${var.ssm_inject_network_latency_percentage_of_instances})"
    resource_tag {
      key   = var.ssm_inject_network_latency_target_tags.key
      value = var.ssm_inject_network_latency_target_tags.value
    }
  }
}
