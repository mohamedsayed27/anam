class EndPoints{
static const baseUrl ='https://back.elanaam.ocodaserver.com/api/v2';
static const imagesBaseUrl ='https://back.elanaam.ocodaserver.com/';
static const products ='/products';
static const wishList ='/users/wish-list';
static const changeProductStatus ='/products/toggle-status/';
static const requests ='/requests';
static const previousRequests ='/users/previous-requests';
static  String postReviewProduct({required String id }) =>'/reviews/$id/products';
static  String reviewProduct({required String id }) =>'/products/$id/reviews';
static  String userFollowing({required String id }) =>'/users/$id/followings';
static  String vendorFollowing({required String id }) =>'/vendors/$id/followers';
static const following ='/following';
static const register ='/register';
static const login ='/login';
static const profile ='/profile';
static const vendorDetails ='/vendors';
static const password ='/password';
static const stores ='/stores';
static const laborers ='/laborers';
static const services ='/services';
static const veterinarians ='/veterinarians';
static const categories ='/categories';
static const cities ='/cities';
static const countries ='/countries';
}