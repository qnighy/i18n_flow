require_relative 'node'

module I18nFlow::YamlAstProxy
  class Sequence < Node
    def_delegators :indexed_object, :==, :<<, :size, :delete_at

    def each
      indexed_object.each.with_index do |o, i|
        yield i, wrap(o, key: i)
      end
    end

    def merge!(other)
      return unless other&.is_a?(Sequence)

      indexed_object.concat(other.send(:indexed_object))
    end

    def keys
      (0...size).to_a
    end

  private

    def indexed_object
      node.children
    end
  end
end
