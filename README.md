# Test 

> ./test.sh

Output of `test.sh` is logged to `stdout.log`, `stderr.log`. The output of the containers can be found in `container.log`.
The most relevant output is in `stdout.log`

This test takes some time. You can watch its progress with:
> tail -f stdout.log

You can see that initially everything is fine. We have 2/2 replicas of version 1.
After about 2 minutes, we have 3/2 containers until we reach 4/2.
 