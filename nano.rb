require 'formula'

class Nano < Formula
  homepage 'http://www.nano-editor.org/'
  url 'http://www.nano-editor.org/dist/v2.3/nano-2.3.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/nano/nano-2.3.2.tar.gz'
  sha1 '5d4bed4f15088fc3cba0650a89bd343b061f456d'

  depends_on "homebrew/dupes/ncurses"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--disable-nls",
                          "--enable-utf8"
    system "make install"
  end
end
