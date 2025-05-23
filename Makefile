deploy:
	rsync -avz . root@195.161.68.45:~/upscale-production
	ssh root@195.161.68.45 "\
		cd upscale-production && \
		docker build -t upscale-production . && \
		docker rm -f upscale-production || true && \
		docker run --restart unless-stopped -d --name upscale-production -p 3000:3000 upscale-production \
	"
