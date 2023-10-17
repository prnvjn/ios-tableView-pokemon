//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    private var posts: [Post] = []
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchPosts()
        table.dataSource = self
        table.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("🍏 numberOfRowsInSection called with movies count: \(posts.count)")
        return posts.count
    }
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("🍏 cellForRowAt called for row: \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let post = posts[indexPath.row]
        
        cell.summary?.text = post.summary
        if let photo = post.photos.first {
              let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: cell.imageUrl)
              // Load the photo in the image view via Nuke library...

        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140    }
//https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk
//
    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/pokemon/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts
                    self?.posts = posts
                    self?.table.reloadData()
//                    print("✅ We got \(posts.count) posts!")
//                    for post in posts {
//                        print("🍏 Summary: \(post.summary)")
//                    }
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
