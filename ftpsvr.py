from pyngrok import ngrok

# Set your authtoken from your ngrok account
ngrok.set_auth_token("26eB9yvckCFT8fpaZMsXfRnES3c_59yZgjPQPH4Dt6G3MXmGN")

tunnel = ngrok.connect(21, "tcp")
print("Public Access:", tunnel.public_url)
