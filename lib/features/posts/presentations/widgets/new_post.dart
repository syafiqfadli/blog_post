import 'package:blog_post/features/feature_injection.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/presentations/bloc/add_post/add_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final AddPostCubit _addPostCubit = featureInjection<AddPostCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _addPostCubit,
      child: BlocListener<AddPostCubit, AddPostState>(
        listener: (context, state) {
          if (state is AddPostSuccessful || state is AddPostError) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  children: [
                    Text(
                      "Add New Post",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    TextFormField(
                      controller: _userIdController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }

                        if (!isNumeric(value)) {
                          return "Please enter number only";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text("User ID"),
                        hintText: "User ID",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text("Title"),
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _bodyController,
                      maxLines: 30,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text("Body"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: BlocBuilder<AddPostCubit, AddPostState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (state is AddPostLoading) return;

                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                                fixedSize: const Size.fromHeight(50),
                              ),
                              child: const Text("Cancel"),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: (state is AddPostLoading)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: _addPost,
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size.fromHeight(50),
                                    ),
                                    child: const Text("Add"),
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addPost() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final post = PostEntity(
      id: 0,
      userId: int.parse(_userIdController.text),
      title: _titleController.text,
      body: _bodyController.text,
    );

    _addPostCubit.addPost(post);
  }

  bool isNumeric(String value) {
    if (value.isEmpty) {
      return false;
    }

    return int.tryParse(value) != null;
  }
}
