module Twelve
  class YtDlpWrapper
    def self.download(url)
      base_path = "/tmp/video-#{SecureRandom.hex(8)}"
      template = "#{base_path}.%(ext)s"

      _stdout, stderr, status = Open3.capture3(
        "yt-dlp",
        "-o",
        template,
        url
      )

      raise "yt-dlp failed: #{stderr}" unless status.success?

      path = Dir["#{base_path}.*"].reject { |f| f.end_with?(".part") }.first

      raise "No downloaded file found" unless path

      path
    end
  end
end
