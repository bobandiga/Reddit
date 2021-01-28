import UIKit

final public class LoadImageView: UIImageView {
    
    private var task: URLSessionTask?
    
    public func loadImage(string: String, cache: URLCache? = nil) {
        guard let url = URL(string: string) else { return }
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            return
        }
        task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            #if DEBUG
            print("THREAD IMAGE: ", Thread.current)
            #endif
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                return
            }
            
            URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        })
        task?.resume()
    }
    
    public func cancelLoad() {
        task?.cancel()
        self.image = nil
    }
}
