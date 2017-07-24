FROM centos:centos7

#ADD CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y update; yum clean all
RUN yum install -y epel-release
RUN yum -y install epel-release python-pip mesa-dri-drivers libexif libcanberra-gtk2 libcanberra mariadb-server mariadb; yum clean all

ADD google-chrome-stable_current_x86_64.rpm /google-chrome-stable_current_x86_64.rpm
RUN yum -y install /google-chrome-stable_current_x86_64.rpm
RUN yum clean all
RUN rm /google-chrome-stable_current_x86_64.rpm

RUN wget -N https://chromedriver.storage.googleapis.com/2.30/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && chmod +x chromedriver \
    && mv -f chromedriver /usr/local/share/chromedriver \
    && ln -sf /usr/local/share/chromedriver /usr/local/bin/chromedriver \
    && ln -sf /usr/local/share/chromedriver /usr/bin/chromedriver

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]