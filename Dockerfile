FROM rocker/verse:latest
LABEL maintainer="Ignacio Martinez <ignacio@martinez.fyi>"

# Update package lists and install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    wget \
    graphviz \
    perl \
    # Core LaTeX packages
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    # Additional LaTeX packages that might be needed
    texlive-luatex \
    texlive-xetex \
    texlive-plain-generic \
    # Font packages for mathpazo and other fonts
    texlive-font-utils \
    # Clean up to reduce image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install/update pandoc (rocker/verse should have it, but ensure latest)
RUN /rocker_scripts/install_pandoc.sh

# Install R packages
RUN install2.r --error --skipinstalled \
    rmarkdown \
    knitr \
    tinytex

# Set working directory
WORKDIR /tmp/working_dir

# Default command
CMD ["R"]
