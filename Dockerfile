FROM centos:centos7

RUN yum -y update \
    && yum -y install epel-release \
    && python-pip \
    && mesa-dri-drivers \
    && libexif \
    && libcanberra-gtk2 \
    && libcanberra \
    && python-devel \
    && mysql-devel \
    && gcc \
    && xorg-x11-server-Xvfb \
    && python-dev \
    && unzip \
    && python-crypto; yum clean all

RUN wget https://archive.org/download/Google-Chrome-Legacy-Versions/google-chrome-stable-50.0.2661.86-1.x86_64.rpm \
    && yum -y install /google-chrome-stable_current_x86_64.rpm \
    && yum clean all \
    && rm /google-chrome-stable_current_x86_64.rpm

#RUN wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm \
#    && yum -y install /mysql-community-release-el7-5.noarch.rpm \
#    && yum clean all \
#    && rm /mysql-community-release-el7-5.noarch.rpm

RUN yum install -y
RUN wget https://chromedriver.storage.googleapis.com/2.22/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && chmod +x chromedriver \
    && mv -f chromedriver /usr/local/share/chromedriver \
    && ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver \
    && ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver


ADD requirements.txt /requirements.txt
RUN pip install --upgrade pip \
    && yum install -y \
    && pip install -r /requirements.txt

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]