package com.softwarejobs.job.view.home


import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.GridLayoutManager
import com.google.firebase.database.*
import com.softwarejobs.job.R
import com.softwarejobs.job.data.model.Category
import com.softwarejobs.job.view.adapter.CategoryAdapter
import com.softwarejobs.job.view.adapter.ItemOffsetDecoration
import kotlinx.android.synthetic.main.fragment_home.*


class HomeFragment : Fragment() {
    private lateinit var mDatabase: DatabaseReference
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_home, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        mDatabase = FirebaseDatabase.getInstance().getReference("categories")
        mDatabase.addValueEventListener(object : ValueEventListener {
            override fun onCancelled(p0: DatabaseError) {
                Log.d("HomeFragment error", " " + p0.message)
            }

            override fun onDataChange(snapshot: DataSnapshot) {
                for (dataSnapShot in snapshot.children) {
                    dataSnapShot.getValue(Category::class.java)!!
                    snapshot.children.map { it.getValue(Category::class.java) }.toList()
                    var adapter =
                        CategoryAdapter(
                            activity as Activity,
                            snapshot.children.map { it.getValue(Category::class.java)!! })
                    home_rv_categories.adapter = adapter
                    home_rv_categories.layoutManager = GridLayoutManager(context, 2)
                    var itemOffsetDecoration = ItemOffsetDecoration(16)
                    home_rv_categories.addItemDecoration(itemOffsetDecoration)
                }
            }
        })
    }

    companion object {
        fun getInstance(): Fragment {
            return HomeFragment()
        }
    }
}
