

// class CartCubit extends Cubit<BaseState> {
//   CartCubit() : super(const InitState());
//   static CartCubit of(context) => BlocProvider.of(context);
//
//   productFormData.ProdctsFormData prodctsFormData = productFormData.ProdctsFormData();
//
//   void clearCart() {
//     AppStorage.clearCartData();
//   }
//
//   incrment(int index) {
//     emit(const LoadingState());
//     prodctsFormData = ProdctsFormData.fromJson(AppStorage.getCartData());
//     prodctsFormData.products![index].qty = prodctsFormData.products![index].qty! + 1;
//     AppStorage.setCartData(data: prodctsFormData.toJson());
//     emit(const InitState());
//   }
//
//   decrment(int index) {
//     emit(const LoadingState());
//     prodctsFormData = ProdctsFormData.fromJson(AppStorage.getCartData());
//     prodctsFormData.products![index].qty = prodctsFormData.products![index].qty! - 1;
//     AppStorage.setCartData(data: prodctsFormData.toJson());
//     emit(const InitState());
//   }
//
//   void removeItem(int index) {
//     emit(const LoadingState());
//     prodctsFormData = ProdctsFormData.fromJson(AppStorage.getCartData());
//     prodctsFormData.products!.removeAt(index);
//     AppStorage.setCartData(data: prodctsFormData.toJson());
//     emit(const InitState());
//   }
//
//   Future onGetcart(BuildContext context) async {
//     emit(const LoadingState());
//     try {
//       prodctsFormData = ProdctsFormData.fromJson(AppStorage.getCartData());
//       emit(const InitState());
//       return prodctsFormData;
//     } catch (e) {
//       showSnackBar(context, "خطأ في الإتصال");
//     }
//     emit(const InitState());
//   }
//
//   Future<void> AddToCart(BuildContext context, productFormData.Products product) async {
//     emit(const LoadingState());
//     try {
//       prodctsFormData = await onGetcart(context);
//       prodctsFormData.products == null ? prodctsFormData.products = [] : null;
//       prodctsFormData.products!.add(product);
//       AppStorage.setCartData(data: prodctsFormData.toJson());
//       showSnackBar(context, "تم الاضافة بنجاح", isSuccess: true);
//     } catch (e) {
//       showSnackBar(context, "خطأ في الإتصال");
//     }
//     emit(const InitState());
//   }
// }
