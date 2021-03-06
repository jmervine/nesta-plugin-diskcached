# Why?

> Both tests are with Unicorn running 1 worker.

### With Diskcached

	httperf --client=0/1 --server=localhost --port=8080 --uri=/ --send-buffer=4096 --recv-buffer=16384 --num-conns=100 --num-calls=1
	Maximum connect burst length: 1

	Total: connections 100 requests 100 replies 100 test-duration 1.186 s

	Connection rate: 84.3 conn/s (11.9 ms/conn, <=1 concurrent connections)
	Connection time [ms]: min 5.1 avg 11.9 max 31.6 median 9.5 stddev 5.6
	Connection time [ms]: connect 0.1
	Connection length [replies/conn]: 1.000

	Request rate: 84.3 req/s (11.9 ms/req)
	Request size [B]: 62.0

	Reply rate [replies/s]: min 0.0 avg 0.0 max 0.0 stddev 0.0 (0 samples)
	Reply time [ms]: response 11.5 transfer 0.3
	Reply size [B]: header 308.0 content 5203.0 footer 0.0 (total 5511.0)
	Reply status: 1xx=0 2xx=100 3xx=0 4xx=0 5xx=0

	CPU time [s]: user 0.63 system 0.55 (user 53.2% system 46.6% total 99.8%)
	Net I/O: 458.7 KB/s (3.8*10^6 bps)

	Errors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0
	Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0


### Without Diskcached

        httperf --verbose --client=0/1 --server=localhost --port=8080 --uri=/ --send-buffer=4096 --recv-buffer=16384 --num-conns=100 --num-calls=1
        Maximum connect burst length: 1
        
        Total: connections 100 requests 100 replies 100 test-duration 9.898 s
        
        Connection rate: 10.1 conn/s (99.0 ms/conn, <=1 concurrent connections)
        Connection time [ms]: min 83.0 avg 99.0 max 155.0 median 96.5 stddev 12.6
        Connection time [ms]: connect 0.1
        Connection length [replies/conn]: 1.000

        Request rate: 10.1 req/s (99.0 ms/req)
        Request size [B]: 62.0

        Reply rate [replies/s]: min 9.6 avg 9.6 max 9.6 stddev 0.0 (1 samples)
        Reply time [ms]: response 98.6 transfer 0.3
        Reply size [B]: header 308.0 content 5203.0 footer 0.0 (total 5511.0)
        Reply status: 1xx=0 2xx=100 3xx=0 4xx=0 5xx=0

        CPU time [s]: user 6.36 system 3.52 (user 64.2% system 35.6% total 99.8%)
        Net I/O: 55.0 KB/s (0.5*10^6 bps)

        Errors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0
        Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0



