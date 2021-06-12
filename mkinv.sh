>inv
for component in frontend-test catalogue-test cart-test user-test shipping-test payment-test mysql-test mongo-test redis-test rabbitmq-test; do
  IP=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${component} Name=instance-state-name,Values=running | jq '.Reservations[].Instances[].PrivateIpAddress' |xargs)
  if [ -n "${IP}" ]; then
    echo $IP component=${component} ansible_user=root ansible_password=DevOps321 >>inv
  fi
done