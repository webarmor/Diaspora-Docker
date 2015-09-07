#!/bin/bash
pushd ~/webarmor/agent-ruby/lua-hooks/
make clean && make
popd

docker run --name=diaspora --rm -it -p 10080:3000 -v /home/oliver/webarmor/agent-ruby/:/home/diaspora/diaspora/agent-ruby -e IMMUNIO_LOG_LEVEL=debug -e IMMUNIO_LOG_TIMINGS=true -e IMMUNIO_DEV_MODE=true -e IMMUNIO_DEBUG_MODE=true -e IMMUNIO_HELLO_URL=http://immunio:5000 -e IMMUNIO_KEY=test-key -e IMMUNIO_SECRET=test-secret immunio/diaspora

