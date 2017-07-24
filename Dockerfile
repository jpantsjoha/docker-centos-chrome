FROM centos:centos7

ADD CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y update; yum clean all
RUN yum install -y epel-release
RUN yum -y install epel-release python-pip mesa-dri-drivers libexif libcanberra-gtk2 libcanberra python-devel mysql-devel gcc; yum clean all

ADD https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm /google-chrome-stable_current_x86_64.rpm
RUN yum -y install /google-chrome-stable_current_x86_64.rpm
RUN yum clean all
RUN rm /google-chrome-stable_current_x86_64.rpm

ADD http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm /mysql-community-release-el7-5.noarch.rpm
RUN yum -y install /mysql-community-release-el7-5.noarch.rpm
RUN yum clean all
RUN rm /mysql-community-release-el7-5.noarch.rpm

RUN yum install -y unzip
ADD https://chromedriver.storage.googleapis.com/2.30/chromedriver_linux64.zip /chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && chmod +x chromedriver \
    && mv -f chromedriver /usr/local/share/chromedriver \
    && ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver \
    && ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver

RUN pip install --upgrade pip
RUN yum install -y python-dev python-crypto
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN yum install -y xorg-x11-server-Xvfb

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]
#
#FROM d
#
#RUN yum install -y python-devel mysql-devel gcc && pip install mysql
#RUN pip install mysql