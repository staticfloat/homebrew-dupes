require 'formula'

class Tk < Formula
  homepage 'http://www.tcl.tk/'
  url 'http://sourceforge.net/projects/tcl/files/Tcl/8.5.9/tk8.5.9-src.tar.gz'
  version '8.5.9'
  sha1 '161a133e0b653d5fdf6fcff47bdbf768d73f3238'

  # must use a Homebrew-built Tcl since versions must match
  depends_on 'tcl'
  depends_on :x11

  option 'enable-threads', 'Build with multithreading support'
  option 'enable-aqua', 'Build with Aqua support'

  def install
    args = ["--prefix=#{prefix}",
            "--mandir=#{man}",
            "--with-tcl=#{HOMEBREW_PREFIX}/lib"]
    args << "--enable-threads" if build.include? "enable-threads"
    args << "--enable-aqua" if build.include? "enable-aqua"
    args << "--enable-64bit" if MacOS.prefer_64_bit?

    cd 'unix' do
      # required to build Aqua support
      inreplace 'Makefile.in' do |s|
        s.change_make_var! "REZ_SWITCHES", "@REZ_FLAGS@ -i $(GENERIC_DIR) " +
                           "-i $(TCL_GENERIC_DIR) -i #{HOMEBREW_PREFIX}/include"
      end

      # so we can find the necessary Tcl headers
      ENV.append 'CFLAGS', "-I#{HOMEBREW_PREFIX}/include"

      system "./configure", *args
      system "make"
      system "make install"

      ln_s bin+'wish8.5', bin+'wish'
    end
  end
end
