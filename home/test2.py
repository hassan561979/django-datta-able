import ccxt


exchange = ccxt.binance({
        'enableLimitRate':True,
   'apiKey': '8VoC7HTEpPqMmgGsjNlKLxetYLigRZlenkfL8skt2mMOTcuVt424eI8t8F7vaSIN',
    'secret': '3INiNkt7heFFBVeZzzI62Swi3XG54T2Ab9MCNQ1Ljtqr1Eqy3iUx1XZkJAT10ctS',
})
exchange.set_sandbox_mode(True)

bb=exchange.fetch_balance()
print (bb)


