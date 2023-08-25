package kr.co.sl.tmap_raster_flutter_sample

import android.os.Bundle
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import com.skt.Tmap.TMapView
import com.skt.Tmap.TMapMarkerItem
import com.skt.Tmap.TMapPoint
import android.graphics.BitmapFactory
import androidx.core.content.ContextCompat
import androidx.vectordrawable.graphics.drawable.VectorDrawableCompat
import android.widget.ImageView
import android.view.View
import android.widget.Toast
import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor




class TMapActivity : AppCompatActivity() {

    val API_KEY = "JEK9BypcTk7mELuqYhBxk1XQDzBkAncx38APA3Pv" // 발급받은 API 키

    var tmapView: TMapView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_tmap)
        tmapView = TMapView(this)

        val container = findViewById<FrameLayout>(R.id.tmapContainer)
        container.addView(tmapView)

        tmapView?.setSKTMapApiKey(API_KEY)
 
        val vectorImageView = findViewById<ImageView>(R.id.vectorImageView)
        val vectorDrawable = VectorDrawableCompat.create(resources, R.drawable.ui1, null)
        vectorImageView.setImageDrawable(vectorDrawable)

        }


    fun onImageViewClick(view: View) {
        val intent = Intent(this, PinTMap::class.java)
        startActivity(intent)
    }

    fun onImageClickNav(view: View){
        val intent = Intent(this, NavFlutter::class.java)
        startActivity(intent)
    
}
}
