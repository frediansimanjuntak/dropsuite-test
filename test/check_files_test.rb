require "minitest/autorun"
require "find"

records = Dir.glob("./DropsuiteTest/**/*").reject { |f| File.directory?(f) }

contents = []
records.each do |filename|
    file_content = IO.read(filename)
    contents << file_content
end

content_hash = contents.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h
content_hash.each do |key1, arr1|
    content_hash.keys.any? do |k|
        if k.include? key1
            content_hash.delete(k) if content_hash[key1] > content_hash[k]
        end
    end
end
puts content_hash
