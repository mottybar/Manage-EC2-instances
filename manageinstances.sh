#!/bin/bash

start_instance(){
read -p "please enter instance id: " instance_id
if  aws ec2 start-instances --instance-ids $instance_id  > /dev/null 2>&1 ; then
    echo "Instance start succeeded."
else
    echo "Instance start failed."
fi
}

stop_instance(){
read -p "please enter instance id: " instance_id
if  aws ec2 stop-instances --instance-ids $instance_id > /dev/null 2>&1 ; then
    echo "Instance stop succeeded."
else
    echo "Instance stop failed."
fi
}

list_instances(){
aws ec2 describe-instances \
--filters Name=instance-state-name,Values=running \
--query 'Reservations[*].Instances[*].[InstanceId, InstanceType, PublicIpAddress]' \
--output text
}

terminate_instance(){
read -p "please enter instance id: " instance_id
if  aws ec2 terminate-instances --instance-ids $instance_id > /dev/null 2>&1 ; then
    echo "Instance termiante succeeded."
else
    echo "Instance terminate failed."
fi
}

menu(){
menu="
1) start_instance
2) stop_instance
3) list_instances
4) terminate_instance
5) Quit
"
while true;do
echo "$menu"
read -p "please enter your selection: " select
case $select in
1) start_instance ;;
2) stop_instance ;;
3) list_instances ;;
4) terminate_instance ;;
5) exit 1 ;;
*) echo "unknown selection" ;;
esac
done
}

menu
