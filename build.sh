# create gentoo repos dir
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;mkdir -pv /var/db/repos/gentoo; "
# download laster stable stage3 file
sudo chroot /mnt/gentoo /bin/bash -c "wget -qO- https://github.com/gentoo-mirror/gentoo/archive/stable.tar.gz | tar zx --directory /var/db/repos/gentoo --strip-component=1"
# Installd git
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;emerge -v  dev-vcs/git"        
# create notmpfs
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;mkdir -pv /var/tmp/notmpfs"
# remove gentoo repos dir
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;rm -rf  /var/db/repos/gentoo"
# clone gentoo-ci dotfiles
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;cd ;git clone https://github.com/slmoby/gentoo-ci"
# remove old gentoo repos.conf
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;rm -f /etc/portage/repos.conf/gentoo.conf"
# rewrite gentoo repos.conf
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;cp gentoo-ci/gentoo.conf /etc/portage/repos.conf/gentoo.conf"
# sync gentoo mirrors
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;emaint sync --auto"
# time zone
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;echo "Asia/Shanghai" > /etc/timezone"
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;emerge -v --config sys-libs/timezone-data"
#sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;eselect news purge"
# lang
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen"
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gent"
sudo chroot /mnt/gentoo /bin/bash -c  "source /etc/profile;locale-gen"
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;eselect locale set  3"
# bootstrap
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;patch -b <~/gentoo-ci/script/1.patch"
sudo chroot /mnt/gentoo /bin/bash -c "source /etc/profile;bash ~/gentoo-ci/script/bootstrap.sh"
