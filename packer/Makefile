default: list
#image = "myimage"
#bucket = "gs://<mybucket>/"

list:
	@echo "---" $@ "---"
	@gsutil ls -lh $(bucket)

build: build_gcp
	@echo "---" $@ "---"

debug: build_gcp_debug
	@echo "---" $@ "---"

build_gcp:
	@echo "---" $@ "---"
	@time packer build -var-file=variables.json -on-error=ask gcp.json.pkr.hcl

build_gcp_debug:
	@echo "---" $@ "---"
	@time packer build -var-file=variables.json -debug -on-error=ask gcp.json.pkr.hcl

publish:
	@echo "---" $@ "---"
	#@echo gcloud compute images export --destination-uri $(bucket)$(image).tar.gz --image $(image)
