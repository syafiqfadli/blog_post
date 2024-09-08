const _baseUrl = 'https://jsonplaceholder.typicode.com';

class RouteConstant {
  static const getAllPosts = '$_baseUrl/posts';
  static getPost(int postId) => '$_baseUrl/post/$postId';
  static deletePost(int postId) => '$_baseUrl/posts/$postId';
  static getPostComments(int postId) => '$_baseUrl/posts/$postId/comments';
}
