cd src 
make -j
cd ..
./batch_calvin.sh scp
sleep 1
bin/deployment/cluster -c deploy-run.conf -p src/deployment/portfile -d bin/deployment/db m 0 &
tail -f ~/s.log
