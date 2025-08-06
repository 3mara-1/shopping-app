import 'package:big_basket/data/product_data.dart';
import 'package:big_basket/presentation/shared/style/common_widget_style.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  _ShoppingHomeScreenState createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _toggleLanguage() {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('ar', 'EG'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: 12, color: Colors.amber);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: 12, color: Colors.amber);
        } else {
          return Icon(Icons.star_outline, size: 12, color: Colors.grey);
        }
      }),
    );
  }

  String _getFeaturedProductTitle(int index) {
    switch (index) {
      case 0:
        return tr('premium_headphones');
      case 1:
        return tr('smart_watch');
      case 2:
        return tr('wireless_speaker');
      case 3:
        return tr('gaming_laptop');
      default:
        return ShoppingData.featuredProducts[index]['title']!;
    }
  }

  String _getProductTitle(String originalTitle) {
    switch (originalTitle) {
      case 'Wireless Mouse':
        return tr('wireless_mouse');
      case 'Coding Keyboard':
        return tr('coding_keyboard');
      case 'USB-C Hub':
        return tr('usb_c_hub');
      case 'Phone Stand':
        return tr('phone_stand');
      case 'Bluetooth Earbuds':
        return tr('bluetooth_earbuds');
      case 'Smart Watch':
        return tr('smart_watch');
      default:
        return originalTitle;
    }
  }

  String _getOfferTitle(String originalTitle) {
    switch (originalTitle) {
      case '50% Off Gaming Accessories':
        return tr('gaming_accessories_offer');
      case 'Free Shipping Weekend':
        return tr('free_shipping_weekend');
      case 'Bundle Deal: Phone + Case':
        return tr('bundle_deal');
      case 'Student Discount 20%':
        return tr('student_discount');
      case 'Flash Sale: Smartwatches':
        return tr('flash_sale');
      default:
        return originalTitle;
    }
  }

  String _getOfferDescription(String originalDescription) {
    if (originalDescription.contains('Limited time offer on all gaming peripherals')) {
      return tr('gaming_accessories_desc');
    } else if (originalDescription.contains('Get free shipping on orders')) {
      return tr('free_shipping_desc');
    } else if (originalDescription.contains('Buy any smartphone and get')) {
      return tr('bundle_deal_desc');
    } else if (originalDescription.contains('Show your student ID')) {
      return tr('student_discount_desc');
    } else if (originalDescription.contains('Lightning deal on premium smartwatches')) {
      return tr('flash_sale_desc');
    }
    return originalDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: const Color.fromARGB(255, 148, 58, 58),
      // استبدال SingleChildScrollView بـ CustomScrollView
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true, 
            snap: true, 
            title: Text(tr('our_products'),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
            backgroundColor: Colors.teal.shade400,
            foregroundColor: Colors.grey[800],
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: _toggleLanguage,
                icon: Icon(Icons.language,color:Colors.white,),
                tooltip: context.locale == Locale('en', 'US') ? 'العربية' : 'English',
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: CommonWidgetStyle.decoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: ShoppingData.featuredProducts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(ShoppingData.featuredProducts[index]['image']!),
                                  fit: BoxFit.cover,
                                  onError: (error, stackTrace) {
                                    print('Failed to load featured image: $error');
                                  },
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    _getFeaturedProductTitle(index),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: ShoppingData.featuredProducts.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _pageController.animateToPage(
                                  entry.key,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPage == entry.key
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Products Grid
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      tr('featured_products'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: ShoppingData.products.length,
                      itemBuilder: (context, index) {
                        final product = ShoppingData.products[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    product['image'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey[600],
                                          size: 50,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getProductTitle(product['title']),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          _buildStarRating(product['rating']),
                                          SizedBox(width: 4),
                                          Text(
                                            '(${product['rating']})',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            product['price'],
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _showSnackBar(
                                              '${_getProductTitle(product['title'])} ${tr('added_to_cart')}',
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.teal,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Hot Offers Section
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      tr('hot_offers'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: ShoppingData.hotOffers.length,
                      itemBuilder: (context, index) {
                        final offer = ShoppingData.hotOffers[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    offer['image']!,
                                    width: 60,
                                    height: 45,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return SizedBox(
                                        width: 60,
                                        height: 45,
                                        child: Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 60,
                                        height: 45,
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey[600],
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getOfferTitle(offer['title']!),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        _getOfferDescription(offer['description']!),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          height: 1.3,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    tr('hot'),
                                    style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}