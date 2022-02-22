repos="calvin"  # repos name, default
workdir="~"  # we default put our repos under the root
leadrIP="10.1.0.7"
p1="10.1.0.8"
p2="10.1.0.9"
clients=(
      $p1 # p1 follower replica IP
      $p2 # p2 follower replica IP
)

cmd1=""
cmd2=""
cmd3=""
cmd4=""
cmd5=""
cmd6=""

# for the leader replica
if [ $1 == 'scp' ]; then
	:
elif [ $1 == 'kill' ]; then
    echo "kill local"
    eval	$cmd2
elif [ $1 == 'del' ]; then
    echo "del local"
    eval	$cmd3
elif [ $1 == 'install' ]; then 
	:
elif [ $1 == 'init' ]; then
	:
elif [ $1 == 'copy_remote_file' ]; then
    echo "copy the remote file, cmd: $cmd6"
    eval $cmd6
else
  :
fi


cmd1="cd $workdir ; sudo rm -rf $repos; scp -r $username@$leadrIP:$workdir/$repos ."
cmd2=""
cmd3=""
cmd4=""
cmd5=""
cmd6=""

# for the two follower replicas
for host in ${clients[@]}
do
  if [ $1 == 'scp' ]; then
    echo "scp to $host cmd: $cmd1 "
    ssh $host "$cmd1" &
  elif [ $1 == 'kill' ]; then
    echo "kill host $host"
    ssh $host "$cmd2" &
  elif [ $1 == 'del' ]; then
    echo "kill host $host"
    ssh $host "$cmd3" &
  elif [ $1 == 'install' ]; then 
	  :
  elif [ $1 == 'init' ]; then
	  :
  else
	  :
  fi
done

echo "Wait for jobs..."
FAIL=0

for job in `jobs -p`
do
    wait $job || let "FAIL+=1"
done

if [ "$FAIL" == "0" ];
then
    echo "YAY!"
else
    echo "FAIL! ($FAIL)"
fi

