class Ballerina < Formula
  desc "Programming Language for Network Distributed Applications"
  homepage "https://ballerina.io"
  url "https://github.com/s-anjana/ballerina-lang/archive/v1.1.4.tar.gz"

  sha256 "801161f339b54fd78df0b223bd5e47fa4e84499dd8d61346a70fcba10c82bb5c"


  bottle :unneeded

  depends_on :java => "1.8"

  def install
    # Remove Windows files
    rm Dir["bin/*.bat"]

    chmod 0755, "bin/ballerina"

    bin.install "bin/ballerina"
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env("1.8"))
  end

  test do
    (testpath/"helloWorld.bal").write <<~EOS
      import ballerina/io;
      public function main() {
        io:println("Hello, World!");
      }
    EOS
    output = shell_output("#{bin}/ballerina run helloWorld.bal")
    assert_equal "Hello, World!", output.chomp
  end
end

