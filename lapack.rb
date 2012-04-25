require 'formula'

class Lapack < Formula
  homepage 'http://www.netlib.org/lapack/'
  url 'http://www.netlib.org/lapack/lapack-3.4.1.tgz'
  md5 '44c3869c38c8335c2b9c2a8bb276eb55'

  depends_on "homebrew/dupes/openblas" => :optional if ARGV.include? "--openblas"
  depends_on "cmake" => :build

  keg_only :provided_by_osx

  def install
    ENV.fortran

    cmake_args = ["-DCMAKE_INSTALL_PREFIX=#{prefix}", "-Wno-dev"]

    if ARGV.include? "--openblas"
      cmake_args << "-DBLAS_LIBRARIES=#{Formula.factory('openblas').lib}/libopenblas.a"
    else
      cmake_args << "-DUSE_OPTIMIZED_BLAS=1"
    end

    system "cmake", *cmake_args
    system "make", "install"
  end
end
