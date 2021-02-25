class ApacheSpark < Formula
  desc "Engine for large-scale data processing"
  homepage "https://spark.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz"
  mirror "https://archive.apache.org/dist/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz"
  version "2.4.7"
  sha2512 "0F5455672045F6110B030CE343C049855B7BA86C0ECB5E39A075FF9D093C7F648DA55DED12E72FFE65D84C32DCD5418A6D764F2D6295A3F894A4286CC80EF478"
  license "Apache-2.0"
  head "https://github.com/apache/spark.git"

  bottle :unneeded

  conflicts_with "apache-spark", :because => "Differing version of same formula"

  def install
    # Rename beeline to distinguish it from hive's beeline
    mv "bin/beeline", "bin/spark-beeline"

    rm_f Dir["bin/*.cmd"]
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Long = 1000",
      pipe_output(bin/"spark-shell --conf spark.driver.bindAddress=127.0.0.1",
                  "sc.parallelize(1 to 1000).count()")
  end
end
