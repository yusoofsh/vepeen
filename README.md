Vepeen
------------------

```sh
fly launch --region sin --copy-config --no-deploy
fly secrets set TAILSCALE_AUTH_KEY=
fly volumes create data --region sin --size 1
fly deploy
```

Please refer to the [upstream](https://github.com/patte/fly-tailscale-exit) for more details.
