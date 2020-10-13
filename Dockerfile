FROM rocker/shiny-verse:4.0.2
RUN apt-get update && apt-get install -y  gdal-bin git-core libcurl4-openssl-dev libgdal-dev libgeos-dev libgeos++-dev libgit2-dev libpng-dev libssh2-1-dev libssl-dev libudunits2-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN install2.r -r https://packagemanager.rstudio.com/all/344 -e  echarts4r \
                DT \
                tmap \
                golem \
                processx \
                pkgload \
                leaflet \
                htmltools \
                attempt \
                config \
                shinycssloaders \
                shinyWidgets \
                rcartocolor
RUN Rscript -e 'remotes::install_github("tidyverse/ggplot2@59998893ef7d1f5c36b3ecfff93bbe6091d589ba")'
RUN Rscript -e 'remotes::install_github("JohnCoene/typed@31e6d3be6a82486c891fbb615b83811cf698aa5a")'
RUN Rscript -e 'remotes::install_github("hadley/emo@3f03b11491ce3d6fc5601e210927eff73bf8e350")'
RUN Rscript -e 'remotes::install_github("RinteRface/fullPage@ff67444cd7e90472c4a253b5bf203c4b75a22d6c")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');xberlin::run_app()"
